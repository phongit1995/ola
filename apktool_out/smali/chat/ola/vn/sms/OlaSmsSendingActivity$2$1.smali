.class Lchat/ola/vn/sms/OlaSmsSendingActivity$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/sms/OlaSmsSendingActivity$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/sms/OlaSmsSendingActivity$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/sms/OlaSmsSendingActivity$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$2$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$2$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity$2;

    iget-object p1, p1, Lchat/ola/vn/sms/OlaSmsSendingActivity$2;->c:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-virtual {p1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->finish()V

    return-void
.end method
