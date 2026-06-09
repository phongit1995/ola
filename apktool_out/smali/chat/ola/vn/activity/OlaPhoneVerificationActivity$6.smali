.class Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->f(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;->c:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/sms/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;->c:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$6;->b:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
