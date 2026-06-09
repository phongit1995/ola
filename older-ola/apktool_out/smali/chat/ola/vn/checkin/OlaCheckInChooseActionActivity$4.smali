.class Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x3

    const/4 p3, 0x0

    if-ne p2, p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-static {p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->c(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$4;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-static {p2}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-static {p1, p2, p3}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    return p3
.end method
