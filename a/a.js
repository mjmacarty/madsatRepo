var interval = null;
function transFunction() {
	clean();
	$('#selectable').html('Translating <img src="images/translate.gif" width="100">');
	var qString = '';
	qString = $('#database-list').val();
	qString += ':' + $('#query-list').val();
	$.post("bTranslate.jsp", 
			{q : qString},
			function(data, status) {
		
			$('#selectable').html(data);
			$('#translate').removeAttr('disabled');
		});
	
	console.log(qString);
}
function execFunction() {
	clean();
	$('#query-results')
	.html('<img src="images/ajax-loader.gif"><br>Loading...');
	interval = setInterval(statusFunction, 1500);
	var qString = '';
	qString += $('#database-list').val();
	qString += ':' + $('.ui-selected').text();
	$.post("bExecute.jsp", {
		q : qString
	}, function(data, status) {
		if (status == "success") {
			$('#graphicsDisplay').html(data);
			callPlanAgent();
		}
	});
	$('#execute-canned').removeAttr('disabled');
	

}
function callPlanAgent() {
	var qString = '';
	$.post("bResult.jsp", {
		q : qString
	}, function(data, status) {
		if (status == "success") {
			clearInterval(interval);
			$('#query-results').html(data);
		}
	});
}




function statusFunction() {
	jQuery.get('status.txt', {
		"t" : $.now()
	}, function(data,status) {
		if (status == "success") {
		$('#query-results').html('<h1>Query Status</h1><br><br>' + data);
		}
	});
}

function clean() {
	$.post('deleteResult.jsp');
	$('#query-results')
			.html(
					'<h1>Query Results</h1>'
							+ '<p>Select query from Library tab or Analytics tab to display results.</p>');
	$('#graphicsDisplay')
			.html(
					'<h1>Geospatial Area of Interest</h1>'
							+ '<p>This panel will display, if relevant, a graphic of interest.');
}

function cleanQueryResults() {
	$.post('deleteResult.jsp');
	$('#query-results')
			.html(
					'<h1>Query Results</h1>'
							+ '<p>Select query from Library tab or Analytics tab to display results.</p>');
}


