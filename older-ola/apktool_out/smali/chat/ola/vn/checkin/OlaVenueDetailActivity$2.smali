.class Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaVenueDetailActivity;->F()V
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

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    if-eqz p3, :cond_0

    :try_start_0
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/16 p3, 0x42

    if-eq p1, p3, :cond_1

    :cond_0
    const/4 p1, 0x3

    if-ne p2, p1, :cond_4

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    iget-object p1, p1, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->b(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_3
    :goto_0
    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_4
    const/4 p1, 0x0

    return p1
.end method
