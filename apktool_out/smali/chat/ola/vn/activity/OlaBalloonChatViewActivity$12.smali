.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$12;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 p1, 0x0

    if-eqz p3, :cond_1

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p3

    const/16 v0, 0x42

    if-eq p3, v0, :cond_0

    const/4 p3, 0x4

    if-ne p2, p3, :cond_1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iget-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$12;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/EditText;

    move-result-object p3

    invoke-virtual {p3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x1

    invoke-static {p2, p3, p1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/lang/String;IZ)V

    :cond_1
    return p1
.end method
