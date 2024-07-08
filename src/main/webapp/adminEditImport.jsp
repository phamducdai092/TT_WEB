<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</head>
<body>
<table id="example" class="display nowrap" style="width:100%">
    <thead>
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Color</th>
        <th>Quantity</th>
        <th>Date</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Color</th>
        <th>Quantity</th>
        <th>Date</th>
    </tr>
    </tfoot>
</table>
<script>
    $(document).ready(function () {
        $('#example').DataTable({
            ajax: {
                url: 'http://localhost:8080/getImportData',
                dataSrc: ''
            },
            columns: [
                { data: 'id' },
                { data: 'pr_id' },
                { data: 'color_id' },
                { data: 'quantity' },
                {
                    data: 'time',
                    render: function (data, type, row) {
                        return data ? data[0] + '-' +
                            String(data[1]).padStart(2, '0') + '-' +
                            String(data[2]).padStart(2, '0') + ' ' +
                            String(data[3]).padStart(2, '0') + ':' +
                            String(data[4]).padStart(2, '0') + ':' +
                            String(data[5]).padStart(2, '0') : '';
                    }
                }
            ]
        });
    });
</script>
</body>
</html>
