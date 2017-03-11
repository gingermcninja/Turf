//
//  MapGrid.swift
//  Turf
//
//  Created by Paul McGrath on 25/02/2017.
//  Copyright © 2017 Paul McGrath. All rights reserved.
//

import Foundation

class MapGrid {
    var cells = Array<Array<Array<MapCell>>>()
    
    init(origin:MapCell) {
        cells = [[[origin]]]
    }
    
    func getCellFromCLLocationCoordinate2D(location:CLLocationCoordinate2D) -> MapCell {
        return cells[0][0][0]
    }
    
    func hex_to_pixel(h:Hex) -> (Double, Double) {
        let px = kCellWidth * 3/2 * h.q
        let py = kCellWidth * sqrt(3) * (h.r + h.q/2)
        return (px, py)
    }
    
    func pixel_to_hex(x:Double, y:Double) -> Hex {
        //let p = x * 2/3 / kCellWidth
        //let r = (-x / 3 + sqrt(3)/3 * y) / kCellWidth
        return hex_round(h:Hex(q: x * 2/3 / kCellWidth, r: (-x / 3 + sqrt(3)/3 * y) / kCellWidth))
    }
    
    func cube_round(c:Cube) -> Cube {
        var rx = Int(c.x)
        var ry = Int(c.y)
        var rz = Int(c.z)
    
        let x_diff = abs(Double(rx) - c.x)
        let y_diff = abs(Double(ry) - c.y)
        let z_diff = abs(Double(rz) - c.z)
    
        if x_diff > y_diff && x_diff > z_diff {
            rx = -ry-rz
        }
        else if y_diff > z_diff {
            ry = -rx-rz
        }
        else {
            rz = -rx-ry
        }
        return Cube(x: Double(rx), y: Double(ry), z: Double(rz))
    }
    
    func cube_to_hex(c:Cube) -> Hex {
        
        return Hex(q: c.x, r: c.z)
    }
    
    func hex_to_cube(h:Hex) -> Cube {
        return Cube(x: h.q, y: -h.q-h.r, z: h.r)
    }
    
    func hex_round(h:Hex) -> Hex {
        return cube_to_hex(c: cube_round(c:hex_to_cube(h:h)))
    }
    
}
