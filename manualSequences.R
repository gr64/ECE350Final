# move sequences from state 1 to state 2
FrontTopLeftFront2FrontTopRightUp:
	# RF'R'DF'
FrontTopLeftUp2FrontTopRightUp:
	# F'DFDF'
FrontTopLeftLeft2FrontTopRightUp:
	# F #yes this one is done

FrontTopRightFront2FrontTopRightUp:
	# L'FLBRB'
# FrontTopRightUp2FrontTopRightUp:
FrontTopRightRight2FrontTopRightUp:
	# BR'B'L'F'L

FrontBottomLeftFront2FrontTopRightUp:
	# DL'F'L
FrontBottomLeftDown2FrontTopRightUp:
	# L'FFLBRB'
FrontBottomLeftLeft2FrontTopRightUp:
	# DBRB'

FrontBottomRightFront2FrontTopRightUp:
	# BRB'
FrontBottomRightDown2FrontTopRightUp:
	# L'F'LBR'B'L'F'L
FrontBottomRightRight2FrontTopRightUp:
	# L'F'L

# direction of back corners taken from perspective of front
# so BackTopLeft is adjacent to FrontTopLeft
BackTopLeftBack2FrontTopRightUp:
	# R'BRD'D'BRB'
BackTopLeftUp2FrontTopRightUp:
	# FL'F'D'D'BRB'
BackTopLeftLeft2FrontTopRightUp:
	# FL'F'DDL'F'L

BackTopRightBack2FrontTopRightUp: 
	# R' 	#yes this one is done
BackTopRightUp2FrontTopRightUp:
	# LB'L'D'R
BackTopRightRight2FrontTopRightUp:
	# F'RFD'R

BackBottomLeftBack2FrontTopRightUp:
	# D'D'BRB'
BackBottomLeftDown2FrontTopRightUp:
	# DDL'F'LBR'B'L'F'L
BackBottomLeftLeft2FrontTopRightUp:
	# DDL'F'L

BackBottomRightBack2FrontTopRightUp:
	# D'L'F'L
BackBottomRightDown2FrontTopRightUp:
	# D'L'F'LBR'B'L'F'L
BackBottomRightRight2FrontTopRightUp:
	# D'BRB'



FrontTopLeftFront2FrontTopLeftUp:
	# RF'R'B'L'B
#FrontTopLeftUp2FrontTopLeftUp
FrontTopLeftLeft2FrontTopLeftUp:
	# B'LBRFR'

FrontTopRightFront2FrontTopLeftUp:
	# FD'RFR'
FrontTopRightUp2FrontTopLeftUp:
	# R'D'RF
FrontTopRightRight2FrontTopLeftUp:
	# BR'B'D'B'L'B

FrontBottomLeftFront2FrontTopLeftUp:
	# B'L'B
FrontBottomLeftDown2FrontTopLeftUp:
	# DDB'L'BRFR'
FrontBottomLeftLeft2FrontTopLeftUp:
	# RFR'

FrontBottomRightFront2FrontTopLeftUp:
	# D'RFR'
FrontBottomRightDown2FrontTopLeftUp:
	# DDL'FLF'D'B'L'B
FrontBottomRightRight2FrontTopLeftUp:
	# D'B'L'B

BackTopLeftBack2FrontTopLeftUp:
	# L	# yes this one is done
BackTopLeftUp2FrontTopLeftUp:
	# R'BRDL'
BackTopLeftLeft2FrontTopLeftUp:
	# FL'F'DL'

BackTopRightBack2FrontTopLeftUp:
	# LB'L'DDB'L'B
BackTopRightUp2FrontTopLeftUp:
	# B'D'D'BRFR'
BackTopRightRight2FrontTopLeftUp:
	# F'RFD'D'RFR'

BackBottomLeftBack2FrontTopLeftUp:
	# DRFR'
BackBottomLeftDown2FrontTopLeftUp:
	# DRFR'B'LBRFR'
BackBottomLeftLeft2FrontTopLeftUp:
	# DL'

BackBottomRightBack2FrontTopLeftUp:
	# DDB'L'B
BackBottomRightDown2FrontTopLeftUp:
	# DFL'F'LD'RFR'
BackBottomRightRight2FrontTopLeftUp:
	# DDRFR'



FrontTopLeftFront2BackTopLeftUp:
	# L'	#yes this is done
FrontTopLeftUp2BackTopLeftUp:
	# RF'R'D'L
FrontTopLeftLeft2BackTopLeftUp:
	# B'LBD'L

FrontTopRightFront2BackTopLeftUp:
	# L'FLDDFLF'
FrontTopRightUp2BackTopLeftUp:
	# L'F'LD'FLF'
FrontTopRightRight2BackTopLeftUp:
	# BR'B'DDR'B'R

FrontBottomLeftFront2BackTopLeftUp:
	# D'R'B'R
FrontBottomLeftDown2BackTopLeftUp:
	# D'L'D'LFL'F'R'B'R
FrontBottomLeftLeft2BackTopLeftUp:
	# D'FLF'

FrontBottomRightFront2BackTopLeftUp:
	# D'D'FLF'
FrontBottomRightDown2BackTopLeftUp:
	# DDL'DLDDR'B'R
FrontBottomRightRight2BackTopLeftUp:
	# DDR'B'R

BackTopLeftBack2BackTopLeftUp:
	# R'BRFLF'
#BackTopLeftUp2BackTopLeftUp:
BackTopLeftLeft2BackTopLeftUp:
	# FL'F'R'B'R

BackTopRightBack2BackTopLeftUp:
	# LB'L'DB'
BackTopRightUp2BackTopLeftUp:
	# F'RF 
BackTopRightRight2BackTopLeftUp:
	# B

BackBottomLeftBack2BackTopLeftUp:
	# FLF'
BackBottomLeftDown2BackTopLeftUp:
	# R'B'RFL'F'R'B'R
BackBottomLeftLeft2BackTopLeftUp:
	# R'B'R

BackBottomRightBack2BackTopLeftUp:
	# DR'B'R
BackBottomRightDown2BackTopLeftUp:
	# DBD'B'DDFLF'
BackBottomRightRight2BackTopLeftUp:
	# R'BR





FrontTopLeftFront2BackTopRightUp:
	# RF'R'DDF'R'F
FrontTopLeftUp2BackTopRightUp:
	# RFR'DF'R'F
FrontTopLeftLeft2BackTopRightUp:
	# B'LBDDLBL'

FrontTopRightFront2BackTopRightUp:
	# L'FLDLBL'
FrontTopRightUp2BackTopRightUp:
	# BR'B'DLBL'
FrontTopRightRight2BackTopRightUp:
	# BR'B'DR'

FrontBottomLeftFront2BackTopRightUp:
	# DDF'R'F
FrontBottomLeftDown2BackTopRightUp:
	# F'DR'F
FrontBottomLeftLeft2BackTopRightUp:
	# B'DDB

FrontBottomRightFront2BackTopRightUp:
	# DLBL'
FrontBottomRightDown2BackTopRightUp:
	# FDDF'
FrontBottomRightRight2BackTopRightUp:
	# DF'R'F

BackTopLeftBack2BackTopRightUp:
	# R'BRD'B
BackTopLeftUp2BackTopRightUp:
	# R'BRFLF'B'
BackTopLeftLeft2BackTopRightUp:
	# B'

BackTopRightBack2BackTopRightUp:
	# LB'L'F'R'F
#BackTopRightUp2BackTopRightUp:
BackTopRightRight2BackTopRightUp:
	# F'RFLBL'

BackBottomLeftBack2BackTopRightUp:
	# D'LB'L
BackBottomLeftDown2BackTopRightUp:
	# BR'B'RDLBL'
BackBottomLeftLeft2BackTopRightUp:
	# D'F'R'F

BackBottomRightBack2BackTopRightUp:
	# F'R'F
BackBottomRightDown2BackTopRightUp:
	# DDLBF'R'F
BackBottomRightRight2BackTopRightUp:
	# LBL'