<#ftl>
<#macro message code>${springMacroRequestContext.getMessage(code)}</#macro>
<#macro ma code args><#if args?is_enumerable>${springMacroRequestContext.getMessage(code, args)}<#else>${springMacroRequestContext.getMessage(code, [args])}</#if></#macro>
<#macro menu code args=''><#if args?is_enumerable>${springMacroRequestContext.getMessage('menu.'+code)}<#elseif args?has_content>${springMacroRequestContext.getMessage('menu.'+code, [args])}<#else>${springMacroRequestContext.getMessage('menu.'+code)}</#if></#macro>
<#macro page code args=''><#if args?is_enumerable>${springMacroRequestContext.getMessage('page.'+code)}<#elseif args?has_content>${springMacroRequestContext.getMessage('page.'+code, [args])}<#else>${springMacroRequestContext.getMessage('page.'+code)}</#if></#macro>
<#macro cut string l=50 append=''>${string[0..*l]}<#if string?length gt l>${append}</#if></#macro>
<#macro merge name value><#if !.vars[name]??><@"<#assign ${name}=''>"?interpret /></#if><#if value??><@"<#assign ${name}=${name}+'${value},'>"?interpret /></#if></#macro>
<#macro compare sequence=[] string='' output1='' output2=''>${(sequence?is_sequence&&sequence?seq_contains(string)||sequence?is_string&&sequence=string)?then(output1,output2)?no_esc}</#macro>
<#macro dump object><#if object??><#if object?is_string>"${object!}"<#elseif object?is_number>${object}<#elseif object?is_boolean>${object?string('true','false')}<#elseif object?is_date_like>"<#if object?is_datetime>${object?datetime}<#elseif object?is_date_only>${object?date}<#elseif object?is_time>${object?time}</#if>"<#elseif object?is_hash_ex>{<#list object as k,v>"${k}":<@dump v!/><#if k?has_next>,</#if></#list>}<#elseif object?is_enumerable>[<#list object as o><@dump o/><#if o?has_next>,</#if></#list>]</#if></#if></#macro>
<#macro getParameters directive><@("<@"+directive+" showParameters=true><@dump parameters/></@"+directive+">")?interpret/></#macro>
<#macro fileSize size><#if size gt 10*1024*1024*1024*1024>${size/1024/1024/1024/1024}TB<#elseif size gt 1024*1024*1024*1024>${(size/1024/1024/1024/1024)?string('0.##')}TB<#elseif size gt 10*1024*1024*1024>${size/1024/1024/1024}GB<#elseif size gt 1024*1024*1024>${(size/1024/1024/1024)?string('0.##')}GB<#elseif size gt 10*1024*1024>${size/1024/1024}MB<#elseif size gt 1024*1024>${(size/1024/1024)?string('0.##')}MB<#elseif size gt 10*1024>${size/1024}KB<#elseif size gt 1024>${(size/1024)?string('0.##')}KB<#elseif size gt 0>${size}B<#else>0</#if></#macro>
<#function pageMessage code><#return springMacroRequestContext.getMessage('page.'+code,code)/></#function>
<#macro secrecy text maxshow><#local length=text?length/><#if length gt maxshow*2>${text[0..*maxshow]+text[length-maxshow..]?left_pad(length-maxshow,'*')}<#else>${text}</#if></#macro>