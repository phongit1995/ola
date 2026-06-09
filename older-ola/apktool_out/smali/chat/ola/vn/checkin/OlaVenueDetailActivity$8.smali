.class Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/i;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->b(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Z)V

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    iget-object p2, p2, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const-string v0, ""

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    iget-object p1, p1, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    const p2, 0x7f0f00a2

    const v0, 0x7f0f0443

    invoke-static {p1, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
