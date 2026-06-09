.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/p;

.field final synthetic c:Lchat/ola/vn/message/f;

.field final synthetic d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/p;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;->d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;->b:Lchat/ola/vn/message/p;

    iput-object p4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;->c:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/ab;

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v2

    iget-object v3, v1, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    const/4 v4, 0x0

    new-instance v5, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19$1;

    invoke-direct {v5, p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19$1;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;Lchat/ola/vn/entity/ab;)V

    invoke-virtual {v2, v3, v4, v5}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    goto :goto_0

    :cond_0
    return-void
.end method
