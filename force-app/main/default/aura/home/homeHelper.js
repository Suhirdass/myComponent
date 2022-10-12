({
    drawStakedBarChart : function(component, event, h, labelList, chartData, colorList, chartId, showInCurrency) { 
        var hasValues = false;
        var dataSets = [];
        var i = 0;
        for ( var key in chartData ) {
            if(i> colorList.length-1)
                i = 0;
            var dataset = {label:key, data:chartData[key],backgroundColor: colorList[i]};
            dataSets.push(dataset);
            i++;
            hasValues = true;
        }
        var width = 0;
        var height = 0;
        if(showInCurrency){
        	width = (window.innerWidth-document.getElementsByClassName("cMainNavigationMenu")[0].offsetWidth- 80 );
            const userAgent = navigator.userAgent.toLowerCase();
			const isTablet = /(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent);
			if(!isTablet)
            	width = width/2;    
        	height = 273;   
        }else{
            width = (window.innerWidth-document.getElementsByClassName("cMainNavigationMenu")[0].offsetWidth- 50 );
        	height = 440;
        }
        var ctx = document.getElementById(chartId);
        ctx.width = width;
        ctx.height = height;        
        var ticks = {
			callback: function(value, index, values) {
				if(showInCurrency)
					return '$' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				else
					return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}                            
		};
        if(!hasValues){
            ticks.min= 0;
            ticks.max= 1;
            ticks.stepSize= 1
        }
        var myChart = new Chart(ctx, {
  			type: 'bar',
  			data: {
    			labels: labelList,
      			datasets:dataSets
  			},
  			options: {
                responsive : false,
      			legend: {
                    display:false
      			},
    			scales: {
      				xAxes: [{ stacked: true }],
      				yAxes: [{ 
                        stacked: true,
                        ticks:ticks
                    }]
    			},
                tooltips:{
                    callbacks:{
                        label: function(tooltipItem, data) {
                            var label = data.datasets[tooltipItem.datasetIndex].label || '';        
                            if (label) {
                                label += ': ';
                            }
                            if(showInCurrency)
                            	return label + '$' + tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                            else
                                return  label+ tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        }
                    }
                }
  			}
		});
    },
    drawBarChart : function(component, event, h, labelList, chartData, chartId, hasValues) {   
        var width = 0;
        var height = 0;        
        width = (window.innerWidth-document.getElementsByClassName("cMainNavigationMenu")[0].offsetWidth- 80 );
        const userAgent = navigator.userAgent.toLowerCase();
        const isTablet = /(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent);
        if(!isTablet)
            width = width/2;    
        height = 273;   
        var ctx = document.getElementById(chartId);
        ctx.width = width;
        ctx.height = height;        
        var ticks = {
            beginAtZero: true,
			callback: function(value, index, values) {
                return '$' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }                            
		};
        if(!hasValues){
            ticks.min= 0;
            ticks.max= 1;
            ticks.stepSize= 1
        }
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labelList,
                datasets: [{
                    label: '',
                    data: chartData,
                    backgroundColor: "#518397",/*94E7A9*/
                }]
            },            
            options: {
                legend: {
                    display:false
      			},
                responsive: false,
                scales: {
                    xAxes: [
                        {
                        	gridLines: {
                                offsetGridLines: true
                            }
                        },
                    ],
                    yAxes: [{
                        ticks:ticks                       
                    }]
                },
                tooltips:{
                    callbacks:{
                        label: function(tooltipItem, data) {
                            return  '$' + tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        }
                    }
                }
            }
        });
    }    
})