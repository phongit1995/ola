.class Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;

.field final synthetic val$asyncTask:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;->this$1:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;->val$asyncTask:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;->this$1:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;

    iget-object v0, v0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->isCancelled()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;->val$asyncTask:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->isCancelled()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;->val$asyncTask:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getThreadPoolExecutor()Ljava/util/concurrent/Executor;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Void;

    invoke-virtual {v0, v1, v2}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    :cond_0
    return-void
.end method
