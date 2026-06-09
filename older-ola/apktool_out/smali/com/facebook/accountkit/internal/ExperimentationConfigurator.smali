.class final Lcom/facebook/accountkit/internal/ExperimentationConfigurator;
.super Ljava/lang/Object;


# static fields
.field private static final FEATURE_PARAMETER_KEY:Ljava/lang/String; = "key"

.field private static final FEATURE_PARAMETER_VALUE:Ljava/lang/String; = "value"

.field private static final GRAPH_PATH_GET_CONFIGURATION:Ljava/lang/String; = "experimentation_configuration"

.field private static final PARAMETER_UNIT_IDENTIFIER:Ljava/lang/String; = "unit_id"

.field private static final RESPONSE_PARAMETER_CREATE_TIME:Ljava/lang/String; = "create_time"

.field private static final RESPONSE_PARAMETER_DATA:Ljava/lang/String; = "data"

.field private static final RESPONSE_PARAMETER_FEATURE_SET:Ljava/lang/String; = "feature_set"

.field private static final RESPONSE_PARAMETER_TTL:Ljava/lang/String; = "ttl"

.field private static final RESPONSE_PARAMETER_UNIT_ID:Ljava/lang/String; = "unit_id"


# instance fields
.field private applicationContext:Landroid/content/Context;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->downloadExperimentationConfiguration(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->buildGraphRequest(Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$200(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->applicationContext:Landroid/content/Context;

    return-object p0
.end method

.method private buildGraphRequest(Ljava/lang/String;Ljava/lang/String;)Lcom/facebook/accountkit/internal/AccountKitGraphRequest;
    .locals 6
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    const-string v0, "unit_id"

    invoke-static {v3, v0, p2}, Lcom/facebook/accountkit/internal/Utility;->putNonNullString(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V

    new-instance p2, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    sget-object v5, Lcom/facebook/accountkit/internal/HttpMethod;->GET:Lcom/facebook/accountkit/internal/HttpMethod;

    const/4 v1, 0x0

    const/4 v4, 0x0

    move-object v0, p2

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lcom/facebook/accountkit/internal/AccountKitGraphRequest;-><init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Landroid/os/Bundle;ZLcom/facebook/accountkit/internal/HttpMethod;)V

    return-object p2
.end method

.method private downloadExperimentationConfiguration(Ljava/lang/String;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getThreadPoolExecutor()Ljava/util/concurrent/Executor;

    move-result-object v0

    new-instance v1, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$2;

    invoke-direct {v1, p0, p1}, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$2;-><init>(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method getExperimentationConfiguration()Lcom/facebook/accountkit/internal/ExperimentationConfiguration;
    .locals 2

    new-instance v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->applicationContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;-><init>(Landroid/content/Context;)V

    return-object v0
.end method

.method initialize(Landroid/content/Context;)V
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Validate;->checkInternetPermissionAndThrow(Landroid/content/Context;)V

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator;->applicationContext:Landroid/content/Context;

    invoke-static {}, Lcom/facebook/accountkit/internal/Utility;->getThreadPoolExecutor()Ljava/util/concurrent/Executor;

    move-result-object p1

    new-instance v0, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/internal/ExperimentationConfigurator$1;-><init>(Lcom/facebook/accountkit/internal/ExperimentationConfigurator;)V

    invoke-interface {p1, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method
