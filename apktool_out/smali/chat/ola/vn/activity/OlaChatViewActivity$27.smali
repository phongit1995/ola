.class Lchat/ola/vn/activity/OlaChatViewActivity$27;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->a_(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/p;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/message/f;

.field final synthetic d:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/p;Ljava/lang/String;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/p;->b(B)V

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->b:Ljava/lang/String;

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity$27;)V

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->l(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/b/o;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    return-void
.end method
