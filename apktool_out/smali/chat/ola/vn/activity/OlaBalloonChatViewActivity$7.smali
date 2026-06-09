.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/aa;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/message/f;

.field final synthetic d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/aa;Ljava/lang/String;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->c:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/aa;->b(B)V

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->b:Ljava/lang/String;

    const-string v2, "mp3"

    new-instance v3, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;)V

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v2, v4, v3}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    return-void
.end method
