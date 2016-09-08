<?php
	// Turn on error reporting
	ini_set("display_errors", "On");
	
	// Connect to database
	$mysqli = new mysqli("oniddb.cws.oregonstate.edu", "volairn-db", "33Zx3B8SMV4iFsYF", "volairn-db");
	
	// Handle connection error
	if($mysqli->connect_errno){
		echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
	}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Niza Volair: Projects</title>
		<link rel="stylesheet" href="style.css" type="text/css">
	</head>

 	<body>
		<div class="centered">
			<h1>Projects</h1>

			<!--Pager-->
			<span>
				<a class="button" href="NizaVolair.html">Home</a>
				<a class="button" href="Skills.php">Skills</a>
				<a class="button" href="Courses.php">Courses</a>
			</span>
		</div>		
			
		<br>
		

		
 		<!--All Projects-->
		<table>
			<?php
				// Prepare artwork selection statement
				if(!($stmt = $mysqli->prepare("SELECT p.name, p.description, p.link, p.image, c.name, c.id  FROM Projects p 
												LEFT JOIN Courses c ON cid = c.id
												ORDER BY c.id DESC"))){
					echo "Prepare failed: " . $stmt->errno . " " . $stmt->error;
				}

				// Execute statement
				if(!$stmt->execute()){
					echo "Execute failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
				}

				// Bind results to table
				if(!$stmt->bind_result($name, $description, $link, $image, $course, $cid)){
					echo "Bind failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
				}

				// Fetch results and print to table
				while($stmt->fetch()){
					// If p.image is NULL, set to placeholder
					if($image == NULL) {
						$image = "http://web.engr.oregonstate.edu/~volairn/projects/images/NoImage.png";
					}

					// If p.cid is NULL, set to placeholder
					if($course == NULL){
						$course = "Personal Project";
					}
					
					// If link is NULL,direct to main github page
					if($link == NULL){
						$link = "https://github.com/NizaVolair";
					}
					echo "<th colspan=3 height=50>\n" . $name . "\n</th>\n
					<tr>\n<td rowspan=3 colspan=1> \n <img src={$image} width=300 height=100>\n</td>\n</tr>\n
					<tr><td rowspan=1 colspan=2>\n" . $description . "\n</td>\n</tr>\n
					<tr><td rowspan=1 colspan=1>\n" . $course . "\n</td>\n
					<td rowspan=1 colspan=1>\n <a href={$link} >Github</a> \n</td>\n</tr>";
				}

				// Close statement
				$stmt->close();
			?>
		</table>
				
		<!--Projects Language filter-->
		<div class="centered">
			<fieldset>
				<h2>View Projects By Language</h2>	
				<form method="post" action="languageFilter.php"> 
					<fieldset>
						<p>Select Language: <select name="Language">
							<?php
								// Prepare languages selection statement
								if(!($stmt = $mysqli->prepare("SELECT id, name FROM Skills"))){
									echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
								}

								// Execute statement
								if(!$stmt->execute()){
									echo "Execute failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
								}

								// Bind results to drop down menu
								if(!$stmt->bind_result($id, $name)){
									echo "Bind failed: " . $mysqli->connect_errno . " " . $mysqli->connect_error;
								}

								// Fetch results and print to drop down menu
								while($stmt->fetch()){
									echo '<option value=" '. $id . ' "> ' . $name . '</option>\n';
								}

								// Close statement
								$stmt->close();
							?>
						</select></p>
						<input type="submit" name="languageFilter" value="Projects by Language" />
					</fieldset>
				</form>	
			</fieldset>
		</div>
 	</body>
</html>
