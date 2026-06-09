.class public final Lbolts/c;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/content/Context;Landroid/content/Intent;)Landroid/net/Uri;
    .locals 3

    invoke-static {p1}, Lbolts/c;->a(Landroid/content/Intent;)Landroid/os/Bundle;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string v2, "target_url"

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v2, "al_nav_in"

    invoke-static {p0, v2, p1, v1}, Lbolts/i;->a(Landroid/content/Context;Ljava/lang/String;Landroid/content/Intent;Ljava/util/Map;)V

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p0

    return-object p0

    :cond_0
    return-object v1
.end method

.method public static a(Landroid/content/Intent;)Landroid/os/Bundle;
    .locals 1

    const-string v0, "al_applink_data"

    invoke-virtual {p0, v0}, Landroid/content/Intent;->getBundleExtra(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p0

    return-object p0
.end method

.method public static b(Landroid/content/Intent;)Landroid/os/Bundle;
    .locals 1

    invoke-static {p0}, Lbolts/c;->a(Landroid/content/Intent;)Landroid/os/Bundle;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    const-string v0, "extras"

    invoke-virtual {p0, v0}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p0

    return-object p0
.end method
