.class Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x2

    const/4 v3, 0x0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/sms/b;->a(Lchat/ola/vn/c;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const-string v1, "8055"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MGM MS "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const-string v4, "8055"

    invoke-static {v0, v4}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "MGM MS "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->b(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    new-array v2, v2, [Ljava/lang/String;

    const-string v4, "android.permission.SEND_SMS"

    aput-object v4, v2, v3

    const-string v3, "android.permission.RECEIVE_SMS"

    aput-object v3, v2, v1

    const/16 v1, 0x6a

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-virtual {v0, v3}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Z)V

    iget-object v4, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v5, 0x7f0f00a2

    invoke-virtual {v0, v5}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v6, 0x7f0f038f

    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Object;

    sget-object v8, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v8, v8, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    aput-object v8, v7, v3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "\"MGM MS "

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, "\""

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v7, v1

    const-string v1, "8055"

    aput-object v1, v7, v2

    const/4 v1, 0x3

    const-string v2, "8055"

    invoke-static {v2}, Lchat/ola/vn/util/m;->m(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v7, v1

    invoke-virtual {v0, v6, v7}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v1, 0x7f0f0480

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3$1;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3$1;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity$3;)V

    invoke-static/range {v4 .. v9}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
