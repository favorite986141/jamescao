HSTS
===

    <rewrite>
            <rules>
                <rule name="Redirect HTTP to HTTPS" stopProcessing="true">
                    <match url="(.*)" />
                    <conditions>
                        <add input="{HTTPS}" pattern="off" />
                    </conditions>
                    <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
                </rule>
            </rules>
            <outboundRules>
                <rule name="Add the STS header in HTTPS responses">
                    <match serverVariable="RESPONSE_Strict_Transport_Security" pattern=".*" />
                    <conditions>
                        <add input="{HTTPS}" pattern="on" />
                    </conditions>
                    <action type="Rewrite" value="max-age=31536000" />
                </rule>
            </outboundRules>
    </rewrite>

