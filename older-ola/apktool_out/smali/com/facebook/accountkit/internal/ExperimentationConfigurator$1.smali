.class Lcom/facebook/accountkit/internal/ExperimentationConfigurator$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->initialize(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/internal/ExperimentationConfigurator;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$1;->this$0:Lcom/facebook/accountkit/internal/ExperimentationConfigurator;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$1;->this$0:Lcom/facebook/accountkit/internal/ExperimentationConfigurator;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->getExperimentationConfiguration()Lcom/facebook/accountkit/internal/ExperimentationConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->isStale()Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    iget-object v1, p0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$1;->this$0:Lcom/facebook/accountkit/internal/ExperimentationConfigurator;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->getUnitID()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->access$000(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;Ljava/lang/String;)V

    :cond_1
    return-void
.end method
