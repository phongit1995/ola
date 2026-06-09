.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$22;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnKeyListener;


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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$22;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 p1, 0x0

    const/16 p3, 0x42

    if-ne p2, p3, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$22;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iget-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$22;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/EditText;

    move-result-object p3

    invoke-virtual {p3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x1

    invoke-static {p2, p3, p1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/lang/String;IZ)V

    return v0

    :cond_0
    return p1
.end method
