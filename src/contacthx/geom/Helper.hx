package src.contacthx.geom;
import contacthx.geom.PointXY;
import contacthx.geom.VectorStartEnd;

// helper functions
function deg2rad( angleDeg: Float ): Float {
	var rad = (Math.PI/180) * angleDeg;
	return rad;
}

function rad2deg( angleRad : Float ): Float {
	var deg = angleRad / ( Math.PI/180 );
	return deg
}

function getCenter( pointA: PointXY, pointB: PointXY ): PointXY {
	var centerX = (pointA.x + pointB.x) / 2;
	var centerY = (pointA.y + pointB.y) / 2;
	var center = new PointXY( centerX, centerY );
	return center;
}

function translatePoint( point: PointXY, vector: VectorStartEnd ): PointXY {
	var newX = point.x + vector.x;
	var newY = point.y + vector.y;
	var translatedPoint = new PointXY( newX, newY );
	return translatedPoint;
}

// return the counter-clockwise angle between the positive x-axis and a point.
// from 0 degrees to 360 degrees
// see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan2
function calcAngleDegrees( point: PointXY ): Float {
	// angle in degrees between -180 and 180
	var angle = Math.atan2( point.y, point.x) * 180 / Math.PI;
	if( angle < 0 ) angle = 360 + angle;
	return angle;
}

function calcAngleRad( point: PointXY ): Float {
	var angle = Math.atan2( point.y, point.x ); // [-PI, PI]
	if( angle < 0 ) angle = 2 * Math.PI + angle;
	return angle
}
