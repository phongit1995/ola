.class final Lcom/facebook/accountkit/internal/ConsoleLogger;
.super Ljava/lang/Object;


# static fields
.field private static final LOG_TAG_BASE:Ljava/lang/String; = "AccountKitSDK."

.field private static final NEWLINE:Ljava/lang/String; = "\n"


# instance fields
.field private final behavior:Lcom/facebook/accountkit/LoggingBehavior;

.field private contents:Ljava/lang/StringBuilder;

.field private final tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;)V
    .locals 1
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->behavior:Lcom/facebook/accountkit/LoggingBehavior;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "AccountKitSDK."

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->tag:Ljava/lang/String;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->contents:Ljava/lang/StringBuilder;

    return-void
.end method

.method private varargs append(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/ConsoleLogger;->shouldLog()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->contents:Ljava/lang/StringBuilder;

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    return-void
.end method

.method private static log(Lcom/facebook/accountkit/LoggingBehavior;ILjava/lang/String;Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getLoggingBehaviors()Lcom/facebook/accountkit/LoggingBehaviorCollection;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/facebook/accountkit/LoggingBehaviorCollection;->isEnabled(Lcom/facebook/accountkit/LoggingBehavior;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "AccountKitSDK."

    invoke-virtual {p2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AccountKitSDK."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :cond_0
    invoke-static {p1, p2, p3}, Landroid/util/Log;->println(ILjava/lang/String;Ljava/lang/String;)I

    sget-object p1, Lcom/facebook/accountkit/LoggingBehavior;->DEVELOPER_ERRORS:Lcom/facebook/accountkit/LoggingBehavior;

    if-ne p0, p1, :cond_1

    new-instance p0, Ljava/lang/Exception;

    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public static varargs log(Lcom/facebook/accountkit/LoggingBehavior;ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0

    invoke-static {p3, p4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p3

    invoke-static {p0, p1, p2, p3}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x3

    invoke-static {p0, v0, p1, p2}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static varargs log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0

    invoke-static {p2, p3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    const/4 p3, 0x3

    invoke-static {p0, p3, p1, p2}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private shouldLog()Z
    .locals 2

    invoke-static {}, Lcom/facebook/accountkit/AccountKit;->getLoggingBehaviors()Lcom/facebook/accountkit/LoggingBehaviorCollection;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->behavior:Lcom/facebook/accountkit/LoggingBehavior;

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/LoggingBehaviorCollection;->isEnabled(Lcom/facebook/accountkit/LoggingBehavior;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method appendKeyValue(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3

    const-string v0, "  %s:\t%s\n"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 p1, 0x1

    aput-object p2, v1, p1

    invoke-direct {p0, v0, v1}, Lcom/facebook/accountkit/internal/ConsoleLogger;->append(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method appendLine(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/ConsoleLogger;->shouldLog()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->contents:Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    return-void
.end method

.method public log()V
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->behavior:Lcom/facebook/accountkit/LoggingBehavior;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->tag:Ljava/lang/String;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->contents:Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x3

    invoke-static {v0, v3, v1, v2}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;ILjava/lang/String;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/ConsoleLogger;->contents:Ljava/lang/StringBuilder;

    return-void
.end method
