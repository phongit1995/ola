.class Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2$1;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    :try_start_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2$1;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "MGM XT "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2$1;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaPhoneVerificationActivity$2;->a:Lchat/ola/vn/activity/OlaPhoneVerificationActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
