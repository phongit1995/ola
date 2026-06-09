.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->a:I

    iput p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->a:I

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    iget v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->a:I

    iget v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->b:I

    invoke-virtual {v1, v2, v3}, Landroid/widget/ListView;->setSelectionFromTop(II)V

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
