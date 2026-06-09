.class Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->onPostExecute(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->access$000(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    new-instance v7, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->access$100(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v3

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->access$200(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;

    move-result-object v4

    const/4 v2, 0x0

    const/4 v6, 0x0

    move-object v1, v7

    move v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;-><init>(Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;ILcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;)V

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getBackgroundExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v1

    new-instance v2, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;

    invoke-direct {v2, p0, v7}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1$1;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    mul-int/lit8 v0, v0, 0x5

    int-to-long v3, v0

    sget-object v0, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v1, v2, v3, v4, v0}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask$1;->this$0:Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->access$100(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;->isLoginRequest()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {v7}, Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;->setCurrentAsyncTask(Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;)V

    :cond_0
    return-void
.end method
