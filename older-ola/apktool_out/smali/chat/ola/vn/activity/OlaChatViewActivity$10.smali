.class Lchat/ola/vn/activity/OlaChatViewActivity$10;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/f;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:I

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->e:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->a:Lchat/ola/vn/message/f;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->b:Ljava/lang/String;

    iput p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->c:I

    iput-object p5, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->e:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->a:Lchat/ola/vn/message/f;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->b:Ljava/lang/String;

    iget v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->c:I

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$10;->d:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void
.end method
