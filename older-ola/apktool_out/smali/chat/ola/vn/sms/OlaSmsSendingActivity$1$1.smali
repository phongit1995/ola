.class Lchat/ola/vn/sms/OlaSmsSendingActivity$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/sms/OlaSmsSendingActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/sms/OlaSmsSendingActivity$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/sms/OlaSmsSendingActivity$1$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity$1;

    iget-object p1, p1, Lchat/ola/vn/sms/OlaSmsSendingActivity$1;->a:Lchat/ola/vn/sms/OlaSmsSendingActivity;

    invoke-virtual {p1}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->finish()V

    return-void
.end method
