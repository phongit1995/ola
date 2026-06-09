.class Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;
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

.field final synthetic b:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;->b:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/sms/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;->b:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->c(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$5;->b:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-virtual {v0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
