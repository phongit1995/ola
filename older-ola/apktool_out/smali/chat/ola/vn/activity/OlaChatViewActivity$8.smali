.class Lchat/ola/vn/activity/OlaChatViewActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:I

.field final synthetic c:Z

.field final synthetic d:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;IZ)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->a:Ljava/lang/String;

    iput p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->b:I

    iput-boolean p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->c:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->a:Ljava/lang/String;

    iget v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->b:I

    iget-boolean v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$8;->c:Z

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;IZ)V

    return-void
.end method
