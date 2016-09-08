<?php
	// Turn on error reporting
	ini_set("display_errors", "On");
	
	// Connect to database
	
	// Handle connection error
	if($mysqli->connect_errno){
		echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
	}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Niza Volair: Courses</title>
		<link rel="stylesheet" href="style.css" type="text/css">
	</head>

 	<body>
		<div class="centered">
			<h1>Courses</h1>

				
			<!--Pager-->
			<span>
				<a class="button" href="NizaVolair.html">Home</a>
				<a class="button" href="Projects.php">Projects</a>
				<a class="button" href="Skills.php">Skills</a>
			</span>
		</div>		
			
		<br>
		
 		<!--All Skills-->
		<table>
			<tr>
				<th>Name</th>
				<th>Grade</th>
				<th>Semester</th>
			</tr>
				<?php
					// Prepare skills selection statement
					if(!($stmt = $mysqli->prepare("SELECT c.name, c.num, c.grade, s.season, s.yr FROM Courses c
													LEFT JOIN Semesters s ON c.sid = s.id
													ORDER BY s.id ASC"))){
						echo "Prepare failed: " . $stmt->errno . " " . $stmt->error;
					}

					// Execute statement
					if(!$stmt->execute()){
						echo "Execute failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
					}

					// Bind results to table
					if(!$stmt->bind_result($name, $num, $grade, $season, $year)){
						echo "Bind failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
					}

					// Fetch results and print to table
					while($stmt->fetch()){
						echo "<tr>\n<td>\n" . $name . "\n" . $num . "</td>\n
						<td>\n" . $grade . "\n</td>\n
						<td>\n" . $season . "\n" . $year . "\n</td>\n</tr>";
					}

					// Close statement
					$stmt->close();
				?>
			</table>
		</div>
 	</body>
</html>
