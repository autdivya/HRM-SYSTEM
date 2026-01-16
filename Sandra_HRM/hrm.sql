<?php
session_start();
if (!isset($_SESSION['admin'])) {
    header("Location: login.html");
    exit();
}

include("../backend/connect.php");

// Simple query: join attendance with employees to get name
$sql = "
SELECT 
    a.emp_id,
    e.name,
    a.date,
    a.in_time,
    a.out_time,
    a.working_hours,
    a.status
FROM 
    attendance a
JOIN 
    employees e ON a.emp_id = e.emp_id
ORDER BY 
    a.date DESC, a.emp_id ASC;
";

$result = mysqli_query($conn, $sql);
?>

<!DOCTYPE html>
<html>
<head>
  <title>Attendance Records</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
    th { background-color: #f2f2f2; }
    h2 { margin-bottom: 20px; }
  </style>
</head>
<body>

<h2>Employee Attendance Records</h2>
<table>
  <tr>
    <th>Employee ID</th>
    <th>Name</th>
    <th>Date</th>
    <th>In Time</th>
    <th>Out Time</th>
    <th>Working Hours</th>
    <th>Status</th>
  </tr>

  <?php while($row = mysqli_fetch_assoc($result)) { ?>
    <tr>
      <td><?= $row['emp_id'] ?></td>
      <td><?= $row['name'] ?></td>
      <td><?= $row['date'] ?></td>
      <td><?= $row['in_time'] ?></td>
      <td><?= $row['out_time'] ?></td>
      <td><?= $row['working_hours'] ?></td>
      <td><?= $row['status'] ?></td>
    </tr>
  <?php } ?>
</table>

</body>
</html>
