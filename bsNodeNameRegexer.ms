--bsNodeNameRegexer.ms

/*
	Les options de la regex de base sont un peu compliques a integrer (cf*),
	voila une petite struct qui aide..

	La regex est velue mais resiste bien

	rgx:
	*"^(pr|ch|bg|clone|...) \
	 _[a-z]+_[a-z]{1,2}\d{2,2} \
	 [a-z]{1,1}_(mdl|ctrl|help|bip|mstr|...)\
	 ((_r|l|m_)|)[a-z0-9_]+((_)[a-z]+|(_)[0-9]{2,100})"

	bsnuv = bsNodeNameRegexer()
	bsnuv.getRegexString()
	bsnuv.validateNameString "ch_lewis_b00a_help_l_thigh_ref_541_ac_05x"

	bsnuv = bsNodeNameRegexer entityTypes:#(#pr) -- only props please
	bsnuv.getRegexString()
	bsnuv.validateNameString "ch_lewis_b00a_help_l_thigh_ref_541_ac_05"

	bsnuv.entityTypes = #(#pr, #ch)
	bsnuv.validateNameString "pr_lewis_b00a_mdl_l_thigh_ref_541_ac_05"

	bsnuv = bsNodeNameRegexer entityTypes:#(#pr) objectQualifiers:#(#mdl) -- only mdl from props please
*/

struct bsNodeNameRegexer (

	public
	entityTypes = #(
		#pr,
		#ch,
		#bg,
		#clone
	),
	objectQualifiers = #(
		#mdl,
		#ctrl,
		#help,
		#bip,
		#mstr
	),
	sideQualifiers   = #(
		#r,
		#l,
		#m
	),

	nbCharPrefixGab_min = 1,
	nbCharPrefixGab_max = 2,
	nbCharSuffixGab_min = 1,
	nbCharSuffixGab_max = 1,
	nbDigitGab_min      = 2,
	nbDigitGab_max      = 2,
	nbDigitEnd_min      = 2,
	nbDigitEnd_max      = 5,
	nbCharEnd_min       = 2,
	nbCharEnd_max       = 150,

	fn getEntityTypesString      = (this._getAltRgxStrFromArray this.entityTypes),
	fn getObjectQualifiersString = (this._getAltRgxStrFromArray this.objectQualifiers),
	fn getSideQualifiersString   = (this._getAltRgxStrFromArray this.sideQualifiers),
	fn getRegexString            = (this._getRegexString()),
	fn validateNameString ndName = ((this.rematch ndName).toString() == ndName),
	fn rematch ndName            = (((dotnetobject "System.Text.RegularExpressions.Regex" (getRegexString())).match ndName)),

	private
	fn _getAltRgxStrFromArray ar symbol:"|" = (
		local cnt = ar.count
		local ret = cnt > 0
		if ret then (
			ret = ""
			for i=1 to cnt do (
				local ent = ar[i]
				ret += tolower(ent as string)
				if i < cnt then (ret += symbol)
			)
		)
		ret
	),

	fn _getRegexString = (
		local str = "" as StringStream
		format "^(%)_[a-z]+_[a-z]{%,%}\d{%,%}[a-z]{%,%}_(%)((_%_)|)[a-z0-9_]+((_)[a-z]{%,%}|(_)[0-9]{%,%})" \
				(this.getEntityTypesString()) \
				nbCharPrefixGab_min \
		        nbCharPrefixGab_max \
		        nbDigitGab_min \
		        nbDigitGab_max \
		        nbCharSuffixGab_min \
		        nbCharSuffixGab_max \
		        (this.getObjectQualifiersString()) \
		        (this.getSideQualifiersString symbol:"_)|(_") \
		        nbCharEnd_min \
				nbCharEnd_max \
		        nbDigitEnd_min \
		        nbDigitEnd_max to:str

		str as string
	),

	public
	on create do ()
)

--bsnuv = bsNodeNameRegexer()
--bsnuv.getRegexString()
--bsnuv.validateNameString "ch_lewis_b00a_help_l_thigh_ref_541_ac_05"