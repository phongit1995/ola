.class Lchat/ola/vn/activity/OlaReleaseAppActivity$1;
.super Landroid/os/CountDownTimer;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaReleaseAppActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaReleaseAppActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaReleaseAppActivity;JJ)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Lchat/ola/vn/activity/OlaReleaseAppActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Lchat/ola/vn/activity/OlaReleaseAppActivity;)Landroid/widget/TextView;

    move-result-object v0

    const-string v1, "X"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onTick(J)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Lchat/ola/vn/activity/OlaReleaseAppActivity;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-wide/16 v2, 0x3e8

    div-long/2addr p1, v2

    long-to-double p1, p1

    invoke-static {p1, p2}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p1

    double-to-int p1, p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
