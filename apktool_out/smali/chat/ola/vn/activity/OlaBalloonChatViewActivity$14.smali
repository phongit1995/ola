.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Z

.field final synthetic b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-boolean p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->a:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/EditText;

    move-result-object v1

    iget-boolean v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;->a:Z

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return-void
.end method
