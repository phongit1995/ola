.class Lcom/facebook/accountkit/internal/AppEventsLogger$6;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/internal/AccountKitGraphRequest$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/AppEventsLogger;->buildRequestForSession(Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)Lcom/facebook/accountkit/internal/AccountKitGraphRequestAsyncTask;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

.field final synthetic val$flushState:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;

.field final synthetic val$postRequest:Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

.field final synthetic val$sessionEventsState:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

.field final synthetic val$stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    iput-object p3, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$postRequest:Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    iput-object p4, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$sessionEventsState:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    iput-object p5, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$flushState:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lcom/facebook/accountkit/internal/AccountKitGraphResponse;)V
    .locals 6

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->this$0:Lcom/facebook/accountkit/internal/AppEventsLogger;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$stateKey:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$postRequest:Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    iget-object v4, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$sessionEventsState:Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;

    iget-object v5, p0, Lcom/facebook/accountkit/internal/AppEventsLogger$6;->val$flushState:Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;

    move-object v3, p1

    invoke-static/range {v0 .. v5}, Lcom/facebook/accountkit/internal/AppEventsLogger;->access$700(Lcom/facebook/accountkit/internal/AppEventsLogger;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsStateKey;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Lcom/facebook/accountkit/internal/AccountKitGraphResponse;Lcom/facebook/accountkit/internal/AppEventsLogger$SessionEventsState;Lcom/facebook/accountkit/internal/AppEventsLogger$FlushStatistics;)V

    return-void
.end method
