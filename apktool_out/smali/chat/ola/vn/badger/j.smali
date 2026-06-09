.class public abstract Lchat/ola/vn/badger/j;
.super Ljava/lang/Object;


# instance fields
.field protected a:Landroid/content/Context;


# direct methods
.method protected constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/badger/j;->a:Landroid/content/Context;

    return-void
.end method

.method public static a(Landroid/content/Context;I)V
    .locals 5

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-ltz p1, :cond_c

    const/16 v2, 0x63

    if-le p1, v2, :cond_0

    goto/16 :goto_2

    :cond_0
    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.MAIN"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v3, "android.intent.category.HOME"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    const/high16 v4, 0x10000

    invoke-virtual {v3, v2, v4}, Landroid/content/pm/PackageManager;->resolveActivity(Landroid/content/Intent;I)Landroid/content/pm/ResolveInfo;

    move-result-object v2

    iget-object v2, v2, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v2, v2, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "com.sonyericsson.home"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    new-instance v3, Lchat/ola/vn/badger/k;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/k;-><init>(Landroid/content/Context;)V

    goto/16 :goto_1

    :cond_1
    const-string v4, "com.sec.android.app.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    new-instance v3, Lchat/ola/vn/badger/i;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/i;-><init>(Landroid/content/Context;)V

    goto/16 :goto_1

    :cond_2
    const-string v4, "com.lge.launcher2"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    new-instance v3, Lchat/ola/vn/badger/f;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/f;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_3
    const-string v4, "com.htc.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    new-instance v3, Lchat/ola/vn/badger/g;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/g;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_4
    const-string v4, "com.android.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    new-instance v3, Lchat/ola/vn/badger/b;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/b;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_5
    const-string v4, "com.anddoes.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    new-instance v3, Lchat/ola/vn/badger/c;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/c;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_6
    const-string v4, "org.adw.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_9

    const-string v4, "org.adwfreak.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    goto :goto_0

    :cond_7
    const-string v4, "com.teslacoilsw.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    new-instance v3, Lchat/ola/vn/badger/h;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/h;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_8
    const-string v4, "com.asus.launcher"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a

    new-instance v3, Lchat/ola/vn/badger/d;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/d;-><init>(Landroid/content/Context;)V

    goto :goto_1

    :cond_9
    :goto_0
    new-instance v3, Lchat/ola/vn/badger/a;

    invoke-direct {v3, p0}, Lchat/ola/vn/badger/a;-><init>(Landroid/content/Context;)V

    :cond_a
    :goto_1
    if-nez v3, :cond_b

    const-string p0, "ShortcutBadger is currently not support the home launcher package \"%s\""

    new-array p1, v1, [Ljava/lang/Object;

    aput-object v2, p1, v0

    invoke-static {p0, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Lchat/ola/vn/badger/ShortcutBadgeException;

    invoke-direct {p1, p0}, Lchat/ola/vn/badger/ShortcutBadgeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_b
    :try_start_0
    invoke-virtual {v3, p1}, Lchat/ola/vn/badger/j;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :cond_c
    :goto_2
    const-string p0, "ShortBadger is currently not support the badgeCount \"%d\""

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v1, v0

    invoke-static {p0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance p1, Lchat/ola/vn/badger/ShortcutBadgeException;

    invoke-direct {p1, p0}, Lchat/ola/vn/badger/ShortcutBadgeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method protected a()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/badger/j;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/badger/j;->a:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getComponent()Landroid/content/ComponentName;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected abstract a(I)V
.end method

.method protected b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/badger/j;->a:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
