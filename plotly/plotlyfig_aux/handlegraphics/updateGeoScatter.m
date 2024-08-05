function updateGeoScatter(obj,geoIndex)
    %-INTIALIZATIONS-%

    axIndex = obj.getAxisIndex(obj.State.Plot(geoIndex).AssociatedAxis);
    geoData = obj.State.Plot(geoIndex).Handle;
    axisData = geoData.Parent;
    [xSource, ~] = findSourceAxis(obj,axIndex);

    %---------------------------------------------------------------------%

    %-set trace-%
    if strcmpi(obj.PlotOptions.geoRenderType, 'geo')
        obj.data{geoIndex}.geo = sprintf('geo%d', xSource+1);
        obj.data{geoIndex}.type = 'scattergeo';
    elseif strcmpi(obj.PlotOptions.geoRenderType, 'mapbox')
        obj.data{geoIndex}.subplot = sprintf('mapbox%d', xSource+1);
        obj.data{geoIndex}.type = 'scattermapbox';
    end

    obj.data{geoIndex}.mode = 'markers+text';

    %---------------------------------------------------------------------%

    %-set trace data-%    
    obj.data{geoIndex}.lat = geoData.LatitudeData;
    obj.data{geoIndex}.lon = geoData.LongitudeData;

    %---------------------------------------------------------------------%

    %-set trace marker-%
    marker = extractGeoMarker(geoData, axisData);

    if strcmpi(obj.PlotOptions.geoRenderType, 'mapbox')
        marker.allowoverlap = true;
        marker = rmfield(marker, 'symbol');
        if strcmp(marker.color, 'rgba(0,0,0,0)') && isfield(marker, 'line')
            marker.color = marker.line.color;
        end
    end

    obj.data{geoIndex}.marker = marker;
end
