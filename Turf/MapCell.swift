//
//  MapCell.swift
//  Turf
//
//  Created by Paul McGrath on 10/01/2017.
//  Copyright © 2017 Paul McGrath. All rights reserved.
//

import Foundation

class MapCell {
    var center:CLLocationCoordinate2D
    var path:[CLLocationCoordinate2D]
    var width:Double
    var height:Double
    
    var x:Int
    var y:Int
    var z:Int
    
    init(center:CLLocationCoordinate2D) {
        self.center = center
        self.path = MapCell.getSurroundingHexagonFromCoordinate(coordinate: center)
        self.width = kCellWidth
        self.height = sqrt(3)/2*kCellWidth
        self.x = 0
        self.y = 0
        self.z = 0
        
    }
    
    static func getNearestCenterToPoint(coordinate:CLLocationCoordinate2D, usingReferencePoint reference:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return coordinate
    }
    
    static func getSurroundingHexagonFromCoordinate(coordinate:CLLocationCoordinate2D) -> Array<CLLocationCoordinate2D> {
        var result = [coordinateFromCoordinate(coordinate: coordinate, atDistanceKm: kCellWidth, atBearingDegrees: 30)]
        result.append(coordinateFromCoordinate(coordinate: coordinate, atDistanceKm: kCellWidth, atBearingDegrees: 90))
        result.append(coordinateFromCoordinate(coordinate: coordinate, atDistanceKm: kCellWidth, atBearingDegrees: 150))
        result.append(coordinateFromCoordinate(coordinate: coordinate, atDistanceKm: kCellWidth, atBearingDegrees: 210))
        result.append(coordinateFromCoordinate(coordinate: coordinate, atDistanceKm: kCellWidth, atBearingDegrees: 270))
        result.append(coordinateFromCoordinate(coordinate: coordinate, atDistanceKm: kCellWidth, atBearingDegrees: 330))
        
        return result
    }
    
    static func coordinateFromCoordinate(coordinate:CLLocationCoordinate2D, atDistanceKm distance:Double, atBearingDegrees degree:Double) -> CLLocationCoordinate2D {
        
        let distanceInRadians:Double = distance/6371.0
        let bearingInRadians:Double = radiansFromDegrees(degrees: degree)
        let fromLatRadians:Double = radiansFromDegrees(degrees: coordinate.latitude)
        let fromLongRadians:Double = radiansFromDegrees(degrees: coordinate.longitude)
        
        let toLatRadians:Double = asin(sin(fromLatRadians) * cos(distanceInRadians) + cos(fromLatRadians) * sin(distanceInRadians) * cos(bearingInRadians))
        
        var toLongRadians = fromLongRadians + atan2(sin(bearingInRadians) * sin(distanceInRadians) * cos(fromLatRadians), cos(distanceInRadians) - sin(fromLatRadians) * sin(toLatRadians))
        
        toLongRadians = fmod((toLongRadians + 3*M_PI), (2*M_PI)) - M_PI
        
        return CLLocationCoordinate2D(latitude: degreesFromRadians(radians:toLatRadians), longitude: self.degreesFromRadians(radians:toLongRadians))
    }
    
    static func radiansFromDegrees(degrees:Double) -> Double {
        return degrees * (M_PI/180.0);
    }
    
    static func degreesFromRadians(radians:Double) -> Double {
        return radians * (180/M_PI);
    }

}
