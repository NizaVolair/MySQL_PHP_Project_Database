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
		<title>Niza Volair: Programs by Language</title>
		<link rel="stylesheet" href="style.css" type="text/css">
	</head>

	<body>
		<div class="centered">
			<h1>Programs by Language</h1>
			
			<!--Pager-->
			<span>
				<a class="button" href="NizaVolair.html">Home</a>
				<a class="button" href="Projects.php">Projects</a>
				<a class="button" href="Skills.php">Skills</a>
				<a class="button" href="Courses.php">Courses</a>
			</span>
		</div>		
			
		<br>
			
		<table>
			<tr>
				<th>Language</th>
				<th>Program</th>
				<th>Description</th>
				<th>Link</th>
			</tr>
			<?php
				// Prepare program by language selection statement
				if(!($stmt = $mysqli->prepare("SELECT p.name, p.description, p.link, s.name FROM Projects p 
												INNER JOIN Project_Skills ps ON ps.pid = p.id 
												INNER JOIN Skills s ON s.id = ps.sid
												WHERE s.id = ?
												ORDER BY p.name ASC"))){
					echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
				}

				// Bind statement to form parameters
				if(!($stmt->bind_param("i", $_POST["Language"]))){
					echo "Bind failed: "  . $stmt->errno . " " . $stmt->error;
				}

				// Execute statement
				if(!$stmt->execute()){
					echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
				}
				
				// Bind results to table
				if(!$stmt->bind_result($name, $description, $link, $language)){
					echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
				}

				// Fetch results and print to table
				while($stmt->fetch()){
					// If link is NULL,direct to main github page
					if($link == NULL){
						$link = "https://github.com/NizaVolair";
					}
					
					echo "<tr>\n<td>\n" . $language . "\n</td>\n
					<td>\n" . $name . "\n</td>\n
					<td>\n" . $description . "\n</td>\n
					<td>\n <a href={$link} >Github</a> \n\n</td>\n</tr>";
				}

				// Close statement
				$stmt->close();
			?>
		</table>
	</body>
</html>
