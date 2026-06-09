.class Lchat/ola/vn/activity/BuyVipActivity$1;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$1;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$1;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->a(Lchat/ola/vn/activity/BuyVipActivity;)Landroid/widget/TextView;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    sget-wide v0, Lchat/ola/vn/h;->o:J

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " KEN"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
