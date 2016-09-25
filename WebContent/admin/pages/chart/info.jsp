<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
		String ctx = request.getContextPath();
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
 <script src="<%=ctx %>/admin/plugins/echart/echarts.js"></script>
</head>
<body>
	<section class="content-header">
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>市场分析</a></li>
			<li class="active">分析首页</li>
		</ol>
	</section>
	
	<section class="content">
	<div class="row">
		<div class="col-xs-12">
	   		<div id="bar_cam" style="height:400px;width:50%;float:left"></div>
	   		<div id="bar_sta" style="height:400px;width:50%;float:left"></div>
	   		<div id="pie" style="height:400px;width:1200px;float:left"></div>
	   	</div>
	 </div>
   	</section>
 
<script type="text/javascript">
	function csName(){
	    var cs = {
	    	csNames : [],
	    	sumIncomes : []
	    }
	    $.ajax({
		    type : "POST",
		    async : false, //同步执行
		    url : ctx + '/cs_StatisticsIncome.ac',
		    data : {},
		    
		    success : function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					for ( var i = 0; i < data.datas.length; i++) { 				
						cs.csNames.push(data.datas[i].csName);
						cs.sumIncomes.push(data.datas[i].sumIncome);
					}
				}
				}
			});
			return cs;
		}

	function camData(){
		var datas = {
				values : [],
				keys : []
		};
	    $.ajax({
		    type : "POST",
		    async : false, //同步执行
		    url : ctx + '/extra/getCampusIncome.ac',
		    data : {},
		    
		    success : function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					for (var key in data) {
						datas.values.push(data[key]);
						datas.keys.push(key);
					}
				}
			}
		});
		return datas;
	}
	
	function num_data() {
		var names = []
		//全局的pie数据
		all_data = [];
	    $.ajax({
		    type : "POST",
		    async : false, //同步执行
		    url : ctx + '/extra/getCampusStuentCount.ac',
		    data : {},
		    
		    success : function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					for (var key in data) {
						var temp = {value : '',
								name : '' };
						temp.value = data[key];
						temp.name = key;
						names.push(key);
						all_data.push(temp);
					}
				}
			}
		});
	    console.info(names);
	    console.info(all_data);
		return names;
	}

	require.config({
	    paths: {
	    	echarts: '<%=ctx %>/admin/plugins/echart'
	    }
	});
	
	// 使用
	require(
	    [
	        'echarts',
	        'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
	        'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
	        'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
	    ],
	    DrawCharts  
	    );
		function DrawCharts(ec) {
			cs_data = csName();
			datas_data = camData();
			peo_data = num_data();
		    FunDraw1(ec);  
		    FunDraw2(ec);
		    FunDraw3(ec);
		  /*   FunDraw3(ec);   */
		}  

    function FunDraw1(ec) {
        // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('bar_cam')); 
        
        option = {
        	    title : {
        	        text: '校区收入'
        	    },
        	    tooltip : {
        	        trigger: 'axis'
        	    },
        	    legend: {
        	        data:['校区收入']
        	    },
        	    toolbox: {
        	        show : true,
        	        feature : {
        	            mark : {show: true},
        	            dataView : {show: true, readOnly: false},
        	            magicType : {show: true, type: ['line', 'bar']},
        	            restore : {show: true},
        	            saveAsImage : {show: true}
        	        }
        	    },
        	    calculable : true,
        	    xAxis : [
        	        {
        	            type : 'category',
        	            data : datas_data.keys
        	        }
        	    ],
        	    yAxis : [
        	        {
        	            type : 'value'
        	        }
        	    ],
        	    dataZoom : { show : true, realtime : true, start : 0, end : 100},
        	    series : [
        	        {
        	            name:'校区收入',
        	            type:'bar',
        	            data:datas_data.values,
        	            markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	            },
        	            markLine : {
        	                data : [
        	                    {type : 'average', name: '平均值'}
        	                ]
        	            }
        	        }
        	    ]
        	};
       

        // 为echarts对象加载数据 
        myChart.setOption(option); 
    };
    
    function FunDraw2(ec) {	
        // 基于准备好的dom，初始化echarts图表
         var myChart = ec.init(document.getElementById('bar_sta')); 
        
        var option = {
       		title : {
       	        text: '班级收入'
       	    },
            tooltip: {
                show: true
            },
            legend: {
                data:[' ','班级收入']
            },
            toolbox: {
    	        show : true,
    	        feature : {
    	            mark : {show: true},
    	            dataView : {show: true, readOnly: false},
    	            magicType : {show: true, type: ['line', 'bar']},
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
            xAxis : [
				{
				    type : 'category',
				    data : cs_data.csNames
				}
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            dataZoom : { show : true, realtime : true, start : 0, end : 100},
            series : [
                {
                    name:'班级收入',
                    type:'bar',
                    data:cs_data.sumIncomes,
                    markPoint : {
    	                data : [
    	                    {type : 'max', name: '最大值'},
    	                    {type : 'min', name: '最小值'}
    	                ]
    	            },
    	            markLine : {
    	                data : [
    	                    {type : 'average', name: '平均值'}
    	                ]
    	            }
                }
            ]
        };

        // 为echarts对象加载数据 
        myChart.setOption(option); 
    };
    
    function FunDraw3(ec) {
    	 // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('pie')); 
    	 
        option = {
        	    title : {
        	        text: '各校区人数',
        	        x:'center'
        	    },
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient : 'vertical',
        	        x : 'left',
        	        data: peo_data
        	    },
        	    toolbox: {
        	        show : true,
        	        feature : {
        	            mark : {show: true},
        	            dataView : {show: true, readOnly: false},
        	            restore : {show: true},
        	            saveAsImage : {show: true}
        	        }
        	    },
        	    calculable : true,
        	    series : [
        	        {
        	            name:'学生所在校区',
        	            type:'pie',
        	            radius : '55%',
        	            center: ['50%', '60%'],
        	            data:all_data
        	        }
        	    ]
        	};
   	// 为echarts对象加载数据 
        myChart.setOption(option); 
    }
</script>
</body>
</html>