.class public Lchat/ola/vn/sms/a;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/sms/a$a;
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/sms/a$a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/sms/a$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/sms/a;->a:Lchat/ola/vn/sms/a$a;

    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 5

    :try_start_0
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string p2, "pdus"

    invoke-virtual {p1, p2}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/Object;

    const/4 p2, 0x0

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    const/4 v1, 0x0

    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_2

    aget-object v2, p1, v1

    check-cast v2, [B

    invoke-static {v2}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v2}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object p2

    :cond_0
    invoke-virtual {v2}, Landroid/telephony/SmsMessage;->getDisplayMessageBody()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {v2}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v3

    :cond_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    invoke-static {p2}, Lchat/ola/vn/sms/b;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/sms/a;->a:Lchat/ola/vn/sms/a$a;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/sms/a;->a:Lchat/ola/vn/sms/a$a;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, p2, v0}, Lchat/ola/vn/sms/a$a;->f(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
