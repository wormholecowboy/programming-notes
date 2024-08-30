# REGIONS
Region > Availability Zones (3-6 per region) > 1 or more redundant data centers
Selecting based on laws, features available, proximity, pricing
Over 400 edge locations (points of presence) around the world

# IAM POLICY
User can be in no groups or multiple groups
Groups can only containt users
Policies can be attached to groups or users

version
id - policy id (opt)
statement
    id - statement id (opt)
    effect - allow or disallow
    principal - account/user/role its applied to
    actions - list of api calls allowed or not
    resources - aws service
