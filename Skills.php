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
		<title>Niza Volair: Skills</title>
		<link rel="stylesheet" href="style.css" type="text/css">
	</head>

 	<body>
		<div class="centered">
			<h1>Skills</h1>

				
			<!--Pager-->
			<span>
				<a class="button" href="NizaVolair.html">Home</a>
				<a class="button" href="Projects.php">Projects</a>
				<a class="button" href="Courses.php">Courses</a>
			</span>
		</div>		
			
		<br>
		
 		<!--All Skills-->
		<table>
			<tr>
				<th>Name</th>
				<th>Level</th>
				<th>Years Used</th>
			</tr>
				<?php
					// Prepare skills selection statement
					if(!($stmt = $mysqli->prepare("SELECT s.name, s.yrs_used, l.name FROM Skills s 
													LEFT JOIN Levels l ON lid = l.id
													ORDER BY s.name ASC"))){
						echo "Prepare failed: " . $stmt->errno . " " . $stmt->error;
					}

					// Execute statement
					if(!$stmt->execute()){
						echo "Execute failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
					}

					// Bind results to table
					if(!$stmt->bind_result($name, $years, $level)){
						echo "Bind failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
					}

					// Fetch results and print to table
					while($stmt->fetch()){
						echo "<tr>\n<td>\n" . $name . "\n</td>\n
						<td>\n" . $level . "\n</td>\n
						<td>\n" . $years . "\n</td>\n</tr>";
					}

					// Close statement
					$stmt->close();
				?>
			</table>
		</div>
 	</body>
</html>
