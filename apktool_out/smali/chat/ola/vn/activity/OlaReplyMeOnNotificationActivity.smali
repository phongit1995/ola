.class public Lchat/ola/vn/activity/OlaReplyMeOnNotificationActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Lchat/ola/vn/f/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 8

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReplyMeOnNotificationActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "_me_entry_id"

    const-wide/16 v1, 0x0

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v3

    const-string v0, "me_message"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v5, "_sender"

    invoke-virtual {p1, v5}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "_index"

    const/4 v7, 0x0

    invoke-virtual {p1, v6, v7}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    cmp-long v6, v3, v1

    if-eqz v6, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v0}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v5, v0, v3, v4}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V

    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReplyMeOnNotificationActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    invoke-virtual {v0, p1}, Landroid/app/NotificationManager;->cancel(I)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReplyMeOnNotificationActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReplyMeOnNotificationActivity;->finish()V

    return-void
.end method
