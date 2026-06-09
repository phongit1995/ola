.class Lcom/facebook/accountkit/internal/SeamlessLoginClient$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/SeamlessLoginClient;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/facebook/accountkit/internal/InternalLogger;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/SeamlessLoginClient;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/SeamlessLoginClient;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient$1;->this$0:Lcom/facebook/accountkit/internal/SeamlessLoginClient;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/SeamlessLoginClient$1;->this$0:Lcom/facebook/accountkit/internal/SeamlessLoginClient;

    invoke-static {v0, p1}, Lcom/facebook/accountkit/internal/SeamlessLoginClient;->access$000(Lcom/facebook/accountkit/internal/SeamlessLoginClient;Landroid/os/Message;)V

    return-void
.end method
