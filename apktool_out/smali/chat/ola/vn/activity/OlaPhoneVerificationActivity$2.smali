.class Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->C()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x2

    const/4 v3, 0x0

    if-eqz v0, :cond_5

    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/sms/b;->a(Lchat/ola/vn/c;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v0, v0, Lchat/ola/vn/entity/ag;->u:S

    if-gtz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->b(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)Landroid/widget/CheckBox;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const-string v1, "8655"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MGM BUYVIP "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " xt"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    const/16 v0, 0xfa0

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v1

    const-string v2, "Buy VIP and Verify"

    int-to-long v3, v0

    invoke-virtual {v1, v2, v3, v4}, Lchat/ola/vn/util/f;->a(Ljava/lang/String;J)V

    return-void

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const-string v1, "8055"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MGM XT "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/sms/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v0

    const-string v1, "Verify phone number"

    invoke-virtual {v0, v1}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V

    return-void

    :cond_2
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v0, v0, Lchat/ola/vn/entity/ag;->u:S

    if-gtz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->b(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;)Landroid/widget/CheckBox;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const-string v4, "8655"

    invoke-static {v0, v4}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "MGM BUYVIP "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "  xt"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_1
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->b(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_3

    :cond_4
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const-string v4, "8055"

    invoke-static {v0, v4}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "MGM XT "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    new-array v2, v2, [Ljava/lang/String;

    const-string v4, "android.permission.SEND_SMS"

    aput-object v4, v2, v3

    const-string v3, "android.permission.RECEIVE_SMS"

    aput-object v3, v2, v1

    const/16 v1, 0x6a

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-virtual {v0, v3}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Z)V

    iget-object v4, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v5, 0x7f0f00a2

    invoke-virtual {v0, v5}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v6, 0x7f0f038f

    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Object;

    sget-object v8, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v8, v8, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    aput-object v8, v7, v3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "\"MGM XT "

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

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v1, 0x7f0f0480

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2$1;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2$1;-><init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;)V

    invoke-static/range {v4 .. v9}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
