.class public final Lcom/facebook/accountkit/internal/ExperimentationConfiguration;
.super Ljava/lang/Object;


# static fields
.field private static final AK_PREFERENCES:Ljava/lang/String;

.field private static final DEFAULT_TTL:J

.field private static final PREFERENCE_PREFIX:Ljava/lang/String;

.field private static final PREF_CREATE_TIME:Ljava/lang/String;

.field private static final PREF_TTL:Ljava/lang/String;

.field private static final PREF_UNIT_ID:Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "ExperimentationConfiguration"


# instance fields
.field private final mSharedPrefs:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    sget-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->TAG:Ljava/lang/String;

    sput-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".AK_PREFERENCES"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->AK_PREFERENCES:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".PREF_CREATE_TIME"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_CREATE_TIME:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".PREF_TTL"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_TTL:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".PREF_UNIT_ID"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_UNIT_ID:Ljava/lang/String;

    sget-object v0, Ljava/util/concurrent/TimeUnit;->DAYS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x3

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v0

    sput-wide v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->DEFAULT_TTL:J

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->getSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->mSharedPrefs:Landroid/content/SharedPreferences;

    return-void
.end method

.method private static getSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    sget-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->AK_PREFERENCES:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    return-object p0
.end method

.method static load(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Long;Ljava/util/Map;)V
    .locals 6
    .param p3    # Ljava/lang/Long;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            "Ljava/lang/Long;",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    move-object v0, p0

    move-object v1, p1

    move-object v4, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->saveConfiguration(Landroid/content/Context;Ljava/lang/String;JLjava/lang/Long;Ljava/util/Map;)V

    :cond_1
    return-void
.end method

.method private static saveConfiguration(Landroid/content/Context;Ljava/lang/String;JLjava/lang/Long;Ljava/util/Map;)V
    .locals 1
    .param p4    # Ljava/lang/Long;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "CommitPrefEdits"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/Long;",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    invoke-static {p0}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->getSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    sget-object v0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_CREATE_TIME:Ljava/lang/String;

    invoke-interface {p0, v0, p2, p3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    if-eqz p4, :cond_0

    sget-object p2, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_TTL:Ljava/lang/String;

    invoke-virtual {p4}, Ljava/lang/Long;->longValue()J

    move-result-wide p3

    invoke-interface {p0, p2, p3, p4}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    :cond_0
    sget-object p2, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_UNIT_ID:Ljava/lang/String;

    invoke-interface {p0, p2, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {p5}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/Integer;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object p4, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p5, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    invoke-interface {p0, p3, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    :cond_1
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    return-void
.end method


# virtual methods
.method public exists()Z
    .locals 5

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->mSharedPrefs:Landroid/content/SharedPreferences;

    sget-object v1, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_CREATE_TIME:Ljava/lang/String;

    const-wide/16 v2, -0x1

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public getBooleanValue(Lcom/facebook/accountkit/internal/Feature;)Z
    .locals 0

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->getIntValue(Lcom/facebook/accountkit/internal/Feature;)I

    move-result p1

    if-lez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public getIntValue(Lcom/facebook/accountkit/internal/Feature;)I
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->mSharedPrefs:Landroid/content/SharedPreferences;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREFERENCE_PREFIX:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Feature;->getPrefKey()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/facebook/accountkit/internal/Feature;->getDefaultValue()I

    move-result p1

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p1

    return p1
.end method

.method getUnitID()Ljava/lang/String;
    .locals 3
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->mSharedPrefs:Landroid/content/SharedPreferences;

    sget-object v1, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_UNIT_ID:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method isStale()Z
    .locals 8

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    iget-object v2, p0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->mSharedPrefs:Landroid/content/SharedPreferences;

    sget-object v3, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_CREATE_TIME:Ljava/lang/String;

    invoke-interface {v2, v3, v0, v1}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    iget-object v4, p0, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->mSharedPrefs:Landroid/content/SharedPreferences;

    sget-object v5, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->PREF_TTL:Ljava/lang/String;

    sget-wide v6, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->DEFAULT_TTL:J

    invoke-interface {v4, v5, v6, v7}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    sub-long v6, v0, v2

    invoke-static {v6, v7}, Ljava/lang/Math;->abs(J)J

    move-result-wide v0

    cmp-long v2, v0, v4

    if-lez v2, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method
