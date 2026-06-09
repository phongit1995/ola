.class Lchat/ola/vn/activity/OlaChatViewActivity$9$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity$9;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity$9;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity$9;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$9$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$9;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$9$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$9;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$9;->a:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$9$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$9;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$9;->a:Lchat/ola/vn/message/d;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->b(B)V

    :cond_0
    return-void
.end method
