({
	setValues : function(c, e, h, r) {
		c.set('v.productInventoryWrapperList',r.records);
        c.set('v.totleProductInventoryWrapperList',r.totelRecords);
        c.set('v.productList',r.productList);
        c.set('v.totelPage',r.totelPage);
        c.set('v.cuurentPage',r.cuurentPage);
        c.set('v.pageSize',r.pageSize);
        c.set('v.startRec',r.startRec);
        c.set('v.endRec',r.endRec);
        c.set('v.totelRec',r.totelRec);
        c.set('v.isCommunityPlusUser',r.isCommunityPlusUser);
	},
    getProdcutInvtory : function(c, e, h, s,o,srchTxt,p) {
    	c.set('v.sortField',s);
        c.set('v.sortOrder',o);
        h.request(c, 'fetchInvenotry', {
            sortField:s,
            sortOrder:o,
            searchText:srchTxt,
            pageSize:p,
            fromReport:true
        }, function(r){
            h.setValues(c, event, h, r);
            var data = r.data;
            c.set('v.data',data);
            var pageNumbers = [];
            for (var i = 1; i <= r.totelPage; i++) {
                if(pageNumbers.length < 5)
            		pageNumbers.push(i);
        	}
            c.set('v.pageNumbers', pageNumbers);
            //h.showChangedChartType(c, e, h,data);
        });    
    },
    showChangedChartType : function(c, e, h,data) {
        document.getElementById("chartDiv").innerHTML = "";
        if(data.length > 0){
            var chartType = c.get('v.chartType');
            if(chartType == 'Horizontal')
                h.horizontalbarChart(c, e, h,data);
            else if(chartType == 'Vertical')
                h.verticalbarChart(c, e, h,data);
            else if(chartType == 'Funnel')
                h.funnelChart(c, e, h,data); 
        }
    },
    horizontalbarChart : function(component, event, h,data) {
		var margin = {
            top: 15,
            right: 25,
            bottom: 45,
            left: 300
        };   
        
        var width = 1250 - margin.left - margin.right,
		height = 1000 - margin.top - margin.bottom;
        var swidth = 1250;
        var sheight = 1000;        
        
        var svg = d3.select("#chartDiv")
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform",
              "translate(" + margin.left + "," + margin.top + ")");        
            
        var x = d3.scaleLinear()
        .rangeRound([0, width])
        .domain([0, d3.max(data, function (d) {
            return d.inventory;
        })]);
        
        svg.append("g")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x))
        .selectAll("text")
        .attr("transform", "translate(-10,0)rotate(-45)")
        .style("text-anchor", "end");
            
        var y = d3.scaleBand()
        .rangeRound([0,height])
        .domain(data.map(function (d) {
            return d.productName;
        }))
        .padding(.1);
        svg.append("g")
        .call(d3.axisLeft(y));            
        
        svg.selectAll(".bars")
        .data(data)
        .enter()
        .append("rect")
        .attr("x", x(0) )
        .attr("y", function(d) { return y(d.productName); })
        .attr("width", function(d) { return x(d.inventory); })
        .attr("height", y.bandwidth() )
        .attr("fill", "steelblue")
	},
    verticalbarChart : function(component, event, h,data) {
        var swidth = 1200;
        var sheight = 1000;
        var svg = d3.select("#chartDiv")
        .append("svg")
        .attr("width", swidth)
        .attr("height", sheight);   
        
        var svg = d3.select("svg"),
            margin  = {top: 20, right: 20, bottom: 200, left: 100},
            width   = +svg.attr("width")  - margin.left - margin.right,
            height  = +svg.attr("height") - margin.top  - margin.bottom,
            x       = d3.scaleBand().rangeRound([0, width]).padding(0.2),
            y       = d3.scaleLinear().rangeRound([height, 0]),
            g       = svg.append("g")
        .attr("transform", `translate(${margin.left},${margin.top})`);
        x.domain(data.map(d => d.productName));
        y.domain([0, d3.max(data, d => d.inventory)]);
        
        g.append("g")
        .attr("class", "axis axis-x")
        .attr("transform", `translate(0,${height})`)
        .call(d3.axisBottom(x))
        .selectAll("text")
            .attr("transform", "translate(-10,0)rotate(-45)")
            .style("text-anchor", "end");
        
        g.append("g")
        .attr("class", "axis axis-y")
        .call(d3.axisLeft(y).ticks(10).tickSize(8));
        
        g.selectAll(".bar")
        .data(data)
        .enter().append("rect")
        .attr("class", "bar")
        .attr("x", d => x(d.productName))
        .attr("y", d => y(d.inventory))
        .attr("width", x.bandwidth())
        .attr("fill", "steelblue")
        .attr("height", d => Math.abs(height - y(d.inventory)));    
    },
    funnelChart : function(component, event, h,data) {
            
    },
    sortChart : function(c, event, h, chartSortField,chartSortOrder) {
    	h.request(c, 'sortChartData', {
            sortField:chartSortField,
            sortOrder:chartSortOrder
        }, function(r){
            var data = r.data;
            c.set('v.data',data);
            h.showChangedChartType(c, event, h,data);
        });      
    }
})