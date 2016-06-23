<?php

require_once("class.phpmailer.php");
require_once("class.smtp.php");




/*
 *     Connection to the database
 */
function connectDB()
{
    $host = 'localhost';
    $user = 'root';
    $password = '';
    $base = 'cron_mail';

    $mysqli = new mysqli($host, $user, $password, $base);

    if (!$mysqli->connect_error) {
        mysqli_query($mysqli, "SET NAMES UTF8");
        return $mysqli;
    } else {
        exit("No connect to server!");
    }
}


/*
 *      Receiving user c end-of-life publication
 */
function getDataMail($number=null)
{
    $mysqli = connectDB();

    $days_array = [1, 3, 5];

    if(!is_null($number)){
        $days_array[] = $number;
    }

   $query = "SELECT  TIMESTAMPDIFF(DAY, NOW(), items.publicated_to)+1 As left_days,
                                         users.email, items.id,items.link,items.title FROM `users` JOIN `items` 
                                         ON users.id = items.user_id where items.status=2 AND items.isCheck=0 ";

   foreach ($days_array as $key => $value) {
       if ($value == 1) {
           $query .= "AND items.publicated_to BETWEEN NOW() ";
       }
       elseif ($value == 3) {
           $query .= "AND DATE_ADD(NOW(),INTERVAL 2 DAY) ";
       }
       elseif ($value >= 5) {
           $query .= "or items.publicated_to BETWEEN DATE_ADD(NOW(),INTERVAL ". ($value-1) ." DAY)
                               AND DATE_ADD(NOW(),INTERVAL {$value} DAY)";
       }
   }

   $query .= " LIMIT 100";

   $result = $mysqli->query($query);

    $mail_array = [];
    if (!is_null($result)) {
        $count = 0;
        while ($rows = $result->fetch_assoc()) {
            $mail_array[$count] = $rows;
            $count++;
        }
        return $mail_array;
    }
}


/*
 *      Label sent letters
 */
function setIsChecked()
{
    $mail_array = getDataMail();
    $mysqli = connectDB();

    $postId_array = [];
    for($i=0; $i < count($mail_array); $i++){
        $postId_array[$i] = $mail_array[$i]['id'];
    }

    $date = strtotime(date("Y-m-d h:i:s"));

    foreach($postId_array as $key => $value) {
        echo $value . "<br>";
        $result = $mysqli->query("UPDATE items SET isCheck = 1, last_update = {$date} WHERE id = {$value}");
    }
}


/*
 *      Delete checked fields
 */
function deleteIsChecked()
{
    $mysqli = connectDB();

    $result = $mysqli->query("SELECT last_update FROM items LIMIT 1");

    if(!is_null($result)){
        $rows = $result->fetch_assoc();
        $last_date = ($rows['last_update']);
        $pattern = "/[0-9]{4}-[0-9]{2}-[0-9]{2} (06):[0-9]{2}:[0-9]{2}/";
        $preg_match_result =  preg_match ($pattern, "2016-06-23 06:45:29");

        if($preg_match_result) {
            $select_all = $mysqli->query("SELECT id FROM items WHERE isCheck = 1");

            if (is_null($select_all)) {
                return null;
            }

            $id_array = [];
            $count = 0;
            while ($rows = $select_all->fetch_assoc()) {
                $id_array[$count] = $rows['id'];
                $count++;
            }

            $date = strtotime(date("Y-m-d h:i:s"));

            foreach ($id_array as $key => $value) {
                echo $value . "<br>";
                $result = $mysqli->query("UPDATE items SET isCheck = 0, last_update = {$date} WHERE id = {$value}");
            }
        }
    }

}


/*
 *      Sending emails
 */
function sendMail()
{
    global $argv;
    $argument1 = $argv[1];
    $mail_array = getDataMail($argument1);
    setIsChecked();
    deleteIsChecked();

    $mail = new PHPMailer();

    if(!is_null($mail)){

        $mail->IsSMTP();
        $mail->Host = "smtp.yandex.ru";
        $mail->CharSet = 'UTF-8';
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = "ssl";
        $mail->Port = 465;
        $mail->Username = "yourname";
        $mail->Password = "yourpass";
        $mail->IsHTML(true);
        $mail->setFrom("youremail@gmail.com");

        $mail->Subject = "Завершение срока публикации";

        foreach ($mail_array as $key=>$value){
            $mail->addAddress($value['eamil']);

            $mail->Body = "Завершение срока публикации  №{$value['id']}, <a href='{$value['link']}'>" . $value['title'] . "</a> истекает через "
                . $value['left_days'];

            $mail->send();
        }
    }
}

sendMail();